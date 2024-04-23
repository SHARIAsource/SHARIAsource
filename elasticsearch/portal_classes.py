from datetime import datetime
from db_connection import DatabaseConnection

class PortalDocument:
    def __init__(self, db_cursor, document_id):
        self.cursor = db_cursor
        self.id = document_id
        self.load_document()
        self.fetch_topics()
        self.fetch_themes()
        self.fetch_regions()
        self.fetch_eras()

    def load_document(self):
        # Load the basic properties of the document
        self.cursor.execute("""
            SELECT d.title, dt.name as document_type, d.summary, d.pdf, d.source_name, d.source_url, d.publisher, 
                   d.publisher_location, d.volume_count, d.alternate_titles, d.alternate_authors, l.name as language,
                   d.popular_count, d.created_at, d.updated_at, rt.name as reference_type, d.published, 
                   d.document_style, d.alternate_editors, d.alternate_translators, d.alternate_years, d.published_at,
                   d.citation, d.gregorian_year, d.gregorian_month, d.gregorian_day, d.reviewed,
                   COALESCE(CONCAT(u.first_name, ' ', u.last_name), 'Unknown User') as user_full_name
            FROM documents d
            LEFT JOIN document_types dt ON d.document_type_id = dt.id
            LEFT JOIN languages l ON d.language_id = l.id
            LEFT JOIN reference_types rt ON d.reference_type_id = rt.id
            LEFT JOIN users u ON d.user_id = u.id
            WHERE d.id = %s
        """, (self.id,))
        result = self.cursor.fetchone()
        if result:
            (self.title, self.document_type, self.summary, self.pdf, self.source_name, self.source_url, 
             self.publisher, self.publisher_location, self.volume_count, self.alternate_titles, self.alternate_authors,
             self.language, self.popular_count, self.created_at, self.updated_at, self.reference_type, 
             self.published, self.document_style, self.alternate_editors, self.alternate_translators,
             self.alternate_years, self.published_at, self.citation, self.gregorian_year, self.gregorian_month, 
             self.gregorian_day, self.reviewed, self.user_full_name) = result

    def fetch_topics(self):
        self.cursor.execute("SELECT name FROM topics JOIN documents_topics ON topics.id = documents_topics.topic_id WHERE documents_topics.document_id = %s", (self.id,))
        self.topics = [row[0] for row in self.cursor.fetchall()]

    def fetch_themes(self):
        self.cursor.execute("SELECT name FROM themes JOIN documents_themes ON themes.id = documents_themes.theme_id WHERE documents_themes.document_id = %s", (self.id,))
        self.themes = [row[0] for row in self.cursor.fetchall()]

    def fetch_regions(self):
        self.cursor.execute("SELECT name FROM regions JOIN documents_regions ON regions.id = documents_regions.region_id WHERE documents_regions.document_id = %s", (self.id,))
        self.regions = [row[0] for row in self.cursor.fetchall()]

    def fetch_eras(self):
        self.cursor.execute("SELECT e.name FROM eras e JOIN documents_eras de ON e.id = de.era_id WHERE de.document_id = %s", (self.id,))
        self.eras = [row[0] for row in self.cursor.fetchall()]


def fetch_all_documents(cursor, test=False):
    cursor.execute("SELECT id FROM documents")
    document_ids = cursor.fetchall()
    documents = []
    count = 0
    for doc_id in document_ids:
        doc = PortalDocument(cursor, doc_id[0])
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
        documents = fetch_all_documents(cursor, test=True)
        for doc in documents:
            print(doc.title, doc.topics, doc.themes, doc.regions)
    finally:
        # Clean up
        cursor.close()
        db_connection.close()

if __name__ == "__main__":
    main()