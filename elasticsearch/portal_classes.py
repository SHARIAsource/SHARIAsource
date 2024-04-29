from datetime import datetime
from db_connection import DatabaseConnection
from typing import List, Dict

class Author:
    def __init__(self, id, name, country=None,
                 affiliation=None, orcid=None, link=None, avatar_url=None):
        self.id = id
        self.name = name
        self.country = country
        self.affiliation = affiliation
        self.orcid = orcid
        self.link = link
        self.avatar_url = avatar_url

    def __repr__(self):
        return f"Author(id={self.id}, name={self.name})"


class HierarchicalItem:
    def __init__(self, item_id, name, hierarchy_path=""):
        self.id = item_id
        self.name = name
        self.hierarchy_path = hierarchy_path

    def __repr__(self):
        return f"{self.hierarchy_path if self.hierarchy_path else self.name}"

class Region(HierarchicalItem):
    pass

class Era(HierarchicalItem):
    pass

# def fetch_hierarchical_items_for_document(cursor, document_id):
#     # get all the related regions for the document
#     region_ids = []
#     regions = []
#     cursor.execute(f""" SELECT id, region_id, document_id FROM documents_regions WHERE document_id = %s """, (document_id,))
#     for row in cursor.fetchall():
#         region_id = row[1]
#         region_ids.append(region_id)

#     for region_id in region_ids:
#         cursor.execute(f""" SELECT id, name, parent_id FROM regions WHERE id = %s """, (region_id,))
#         for row in cursor.fetchall():
#             region_id = row[0]
#             name = row[1]
#             parents = []
#             if row[2] is not None:
#                 has_parents = True
#                 parent_id = row[2]
#             else:
#                 has_parents = False
#             while has_parents:
#                 cursor.execute(f""" SELECT id, name, parent_id FROM regions WHERE id = %s """, (parent_id,))
#                 parent_row = cursor.fetchone()
#                 if parent_row:
#                     parent = {
#                         "id": parent_row[0],
#                         "name": parent_row[1]
#                     }
#                     parents.insert(0, parent)
#                     if parent_row[2]:
#                         parent_id = parent_row[2]
#                     else:
#                         has_parents = False
#             hierarchy_path = " > ".join([parent["name"] for parent in parents]) + " > " + name
#             regions.append(Region(region_id, name, hierarchy_path))
#     return regions

def fetch_hierarchical_items_for_document(cursor, document_id, item_type):
    """
    Fetches hierarchical items (regions or eras) related to a document.
    
    Args:
    cursor: Database cursor
    document_id: ID of the document
    item_type: 'regions' or 'eras'
    
    Returns:
    List of HierarchicalItem instances representing the hierarchical items related to the document.
    """
    item_ids = []
    items = []
    table = item_type  # 'regions' or 'eras'
    link_table = f"documents_{item_type}"  # 'documents_regions' or 'documents_eras'
    
    # Fetch all item IDs associated with the document
    cursor.execute(f""" SELECT {item_type[:-1]}_id, document_id FROM {link_table} WHERE document_id = %s """, (document_id,))
    for row in cursor.fetchall():
        item_id = row[0]
        item_ids.append(item_id)

    # Fetch the hierarchy for each item
    for item_id in item_ids:
        cursor.execute(f""" SELECT id, name, parent_id FROM {table} WHERE id = %s """, (item_id,))
        for row in cursor.fetchall():
            item_id = row[0]
            name = row[1]
            parents = []
            parent_id = row[2]
            
            # Build the hierarchy path
            while parent_id is not None:
                cursor.execute(f""" SELECT id, name, parent_id FROM {table} WHERE id = %s """, (parent_id,))
                parent_row = cursor.fetchone()
                if parent_row:
                    parent = {"id": parent_row[0], "name": parent_row[1]}
                    parents.insert(0, parent)
                    parent_id = parent_row[2]
                else:
                    break
            hierarchy_path = " > ".join([parent["name"] for parent in parents]) + " > " + name
            items.append(HierarchicalItem(item_id, name, hierarchy_path))
            
    return items


class PortalDocument:
    def __init__(self, document_id, title, document_type, summary, pdf, source_name, source_url, publisher, 
                 publisher_location, volume_count, alternate_titles, alternate_authors, language, popular_count, 
                 created_at, updated_at, reference_type, published, document_style, alternate_editors, 
                 alternate_translators, alternate_years, published_at, citation, gregorian_year, gregorian_month, gregorian_day,
                 reviewed, user_full_name,authors: List[Author] = None, topics=None, themes=None, regions=None, eras=None, tags=None,
                 referenced_by_documents=None, documents_referenced=None, url=None):
        self.id = document_id
        self.url = url if url else f"https://portal.shariasource.org/documents/{document_id}"
        self.title = title
        self.document_type = document_type
        self.summary = summary
        self.pdf = pdf
        self.source_name = source_name
        self.source_url = source_url
        self.publisher = publisher
        self.publisher_location = publisher_location
        self.volume_count = volume_count
        self.alternate_titles = alternate_titles.split(',') if alternate_titles else []
        self.alternate_authors = alternate_authors.split(',') if alternate_authors else []
        self.language = language
        self.popular_count = popular_count
        self.created_at = self.parse_date(created_at)
        self.updated_at = self.parse_date(updated_at)
        self.reference_type = reference_type
        self.published = published
        self.document_style = document_style
        self.alternate_editors = alternate_editors.split(',') if alternate_editors else []
        self.alternate_translators = alternate_translators.split(',') if alternate_translators else []
        self.alternate_years = alternate_years.split(',') if alternate_years else []
        self.published_at = self.parse_date(published_at)
        self.citation = citation
        self.gregorian_year = gregorian_year if gregorian_year else None
        self.gregorian_month = gregorian_month if gregorian_month else None
        self.gregorian_day = gregorian_day if gregorian_day else None
        self.reviewed = reviewed
        self.user_full_name = user_full_name
        self.topics = topics
        self.themes = themes
        self.regions = regions
        self.eras = eras
        self.authors = authors
        self.tags = tags
        self.referenced_by_documents = referenced_by_documents
        self.documents_referenced = documents_referenced

    def load_additional_details(self, cursor):
        self.fetch_topics(cursor)
        self.fetch_themes(cursor)
        self.fetch_regions(cursor)
        self.fetch_eras(cursor)
        self.fetch_authors(cursor)
        self.fetch_tags(cursor)
        self.fetch_referenced_by_documents(cursor)
        self.fetch_documents_referenced(cursor)

    def fetch_topics(self, cursor):
        cursor.execute("SELECT name FROM topics JOIN documents_topics ON topics.id = documents_topics.topic_id WHERE documents_topics.document_id = %s", (self.id,))
        self.topics = [row[0] for row in cursor.fetchall()]

    def fetch_themes(self, cursor):
        cursor.execute("SELECT name FROM themes JOIN documents_themes ON themes.id = documents_themes.theme_id WHERE documents_themes.document_id = %s", (self.id,))
        self.themes = [row[0] for row in cursor.fetchall()]

    def fetch_regions(self, cursor):
        # cursor.execute("SELECT name FROM regions JOIN documents_regions ON regions.id = documents_regions.region_id WHERE documents_regions.document_id = %s", (self.id,))
        # self.regions = [row[0] for row in cursor.fetchall()]
        self.regions = fetch_hierarchical_items_for_document(cursor, document_id=self.id, item_type="regions")

    def fetch_eras(self, cursor):
        # cursor.execute("SELECT e.name FROM eras e JOIN documents_eras de ON e.id = de.era_id WHERE de.document_id = %s", (self.id,))
        # self.eras = [row[0] for row in cursor.fetchall()]
        self.eras = fetch_hierarchical_items_for_document(cursor, document_id=self.id, item_type="eras")

    def fetch_authors(self, cursor):
        cursor.execute("SELECT id, name FROM authors JOIN authors_documents ON authors.id = authors_documents.author_id WHERE authors_documents.document_id = %s", (self.id,))
        self.authors = [Author(*row) for row in cursor.fetchall()]

    def fetch_tags(self, cursor):
        cursor.execute("SELECT name FROM tags JOIN documents_tags ON tags.id = documents_tags.tag_id WHERE documents_tags.document_id = %s", (self.id,))
        self.tags = [row[0] for row in cursor.fetchall()]
    
    def fetch_referenced_by_documents(self, cursor):
        cursor.execute("SELECT id, title FROM documents WHERE id IN (SELECT document_id FROM document_documents WHERE referenced_id = %s)", (self.id,))
        referenced_by_documents = []
        for row in cursor.fetchall():
            referenced_by_documents.append({"id": row[0], "title": row[1], "url": f"https://portal.shariasource.org/documents/{row[0]}"})
        self.referenced_by_documents = referenced_by_documents

    def fetch_documents_referenced(self, cursor):
        cursor.execute("SELECT id, title FROM documents WHERE id IN (SELECT referenced_id FROM document_documents WHERE document_id = %s)", (self.id,))
        documents_referenced = []
        for row in cursor.fetchall():
            documents_referenced.append({"id": row[0], "title": row[1], "url": f"https://portal.shariasource.org/documents/{row[0]}"})
        self.documents_referenced = documents_referenced
    
    def parse_date(self, date):
        if isinstance(date, datetime):
            return date
        elif isinstance(date, str):
            try:
                return datetime.strptime(date, '%Y-%m-%d %H:%M:%S')
            except ValueError:
                try:
                    return datetime.strptime(date, '%Y-%m-%d')
                except ValueError:
                    return None
        else:
            return None

    def __repr__(self):
        return f"PortalDocument(id={self.id}, title={self.title}, topics={self.topics})"


def fetch_all_documents(cursor, test=False):
    cursor.execute("""
        SELECT 
            d.id, d.title, dt.name as document_type, d.summary, d.pdf, 
            d.source_name, d.source_url, d.publisher, d.publisher_location, 
            d.volume_count, d.alternate_titles, d.alternate_authors, l.name as language, 
            d.popular_count, d.created_at, d.updated_at, rt.name as reference_type, 
            d.published, d.document_style, d.alternate_editors, d.alternate_translators, 
            d.alternate_years, d.published_at, d.citation, d.gregorian_year, 
            d.gregorian_month, d.gregorian_day, d.reviewed,
            COALESCE(CONCAT(u.first_name, ' ', u.last_name), 'Unknown User') as user_full_name
        FROM documents d
        LEFT JOIN document_types dt ON d.document_type_id = dt.id
        LEFT JOIN languages l ON d.language_id = l.id
        LEFT JOIN reference_types rt ON d.reference_type_id = rt.id
        LEFT JOIN users u ON d.user_id = u.id
    """)
    documents = []
    count = 0
    for row in cursor.fetchall():
        doc = PortalDocument(*row)
        doc.load_additional_details(cursor)
        documents.append(doc)
        count += 1
        if test and count > 20:
            break
        if count % 100 == 0:
            print(f"Fetched {count} documents")
    print(f"Completed fetch. Fetched {count} documents")
    return documents

def main():
    try:
        db_connection = DatabaseConnection()
        cursor = db_connection.get_cursor()
        # # document_id = 4614
        # region_hierarchy = fetch_hierarchical_items_for_document(cursor, document_id=4614, item_type="regions")
        # era_hierarchy = fetch_hierarchical_items_for_document(cursor, item_type="eras", document_id=4614)
        # print(region_hierarchy)
        # print(era_hierarchy)

        documents = fetch_all_documents(cursor, test=True)
        for doc in documents:
            print(doc)
    finally:
        # Clean up
        cursor.close()
        db_connection.close()

if __name__ == "__main__":
    main()
