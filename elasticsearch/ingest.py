from db_connection import DatabaseConnection
from datetime import datetime
from elasticsearch import Elasticsearch
from elasticsearch.helpers import bulk
from portal_classes import fetch_all_documents
from dotenv import load_dotenv
import os

index_name = "portal-documents_dev"

def create_es_client():
    # Setup Elasticsearch connection.
    load_dotenv()
    cloud_id = os.getenv("CLOUD_ID")
    password = os.getenv("ELASTIC_CLOUD_PASSWORD")
    es_client = Elasticsearch(
        cloud_id=cloud_id,
        basic_auth=("elastic", password)
    )
    return es_client

def create_index(es_client):
    # Define the mappings
    body = {
        "settings": {
            "analysis": {
                "analyzer": {
                    "hierarchy_analyzer": {
                        "type": "custom",
                        "tokenizer": "path_hierarchy"
                    }
                }
            }
        },
        "mappings": {
            "properties": {
                "title": {"type": "text"},
                "url": {"type": "text"},
                "document_type": {"type": "keyword"},
                "summary": {"type": "text"},
                "snippet": {"type": "alias", "path": "summary"}, # alias for summary
                "pdf": {"type": "text"},
                "pdf_url": {"type": "text"},
                "source_name": {"type": "keyword"},
                "source_url": {"type": "keyword"},
                "publisher": {"type": "keyword"},
                "publisher_location": {"type": "keyword"},
                "volume_count": {"type": "integer"},
                "alternate_titles": {"type": "text"},
                "alternate_authors": {"type": "text"},
                "language": {"type": "keyword"},
                "popular_count": {"type": "integer"},
                "created_at": {"type": "date"},
                "updated_at": {"type": "date"},
                "reference_type": {"type": "keyword"},
                "published": {"type": "boolean"},
                "document_style": {"type": "keyword"},
                "alternate_editors": {"type": "text"},
                "alternate_translators": {"type": "text"},
                "alternate_years": {"type": "text"},
                "published_at": {"type": "date"},
                "citation": {"type": "text"},
                "gregorian_year": {"type": "integer"},
                "gregorian_month": {"type": "integer"},
                "gregorian_day": {"type": "integer"},
                "reviewed": {"type": "boolean"},
                "user_full_name": {
                    "type": "text",
                    "fields": {
                        "keyword": {"type": "keyword"}
                    }
                },
                "topics": {"type": "keyword"},
                "themes": {"type": "keyword"},
                "regions": {
                    "type": "nested",
                    "properties": {
                        "id": {"type": "integer"},
                        "name": {
                            "type": "text",
                            "fields": {
                                "keyword": {"type": "keyword"}
                            }
                        },
                        "hierarchy": {
                            "type": "text",
                            "analyzer": "hierarchy_analyzer"
                        }
                    }
                },
                "eras": {
                    "type": "nested",
                    "properties": {
                        "id": {"type": "integer"},
                        "name": {
                            "type": "text",
                            "fields": {
                                "keyword": {"type": "keyword"}
                            }
                        },
                        "hierarchy": {
                            "type": "text",
                            "analyzer": "hierarchy_analyzer"
                        }
                    }
                },
                "authors": {
                    "type": "nested",
                    "properties": {
                        "id": {"type": "integer"},
                        "name": {
                            "type": "text",
                            "fields": {
                                "keyword": {"type": "keyword"}
                            }
                        }
                    }
                },
                "referenced_by_documents": {
                    "type": "nested",
                    "properties": {
                        "id": {"type": "integer"},
                        "title": {
                            "type": "text",
                            "fields": {
                                "keyword": {"type": "keyword"}
                            }
                        },
                        "url": {"type": "text"}
                    }
                },
                "documents_referenced": {
                    "type": "nested",
                    "properties": {
                        "id": {"type": "integer"},
                        "title": {
                            "type": "text",
                            "fields": {
                                "keyword": {"type": "keyword"}
                            }
                        },
                        "url": {"type": "text"}
                    }
                },
                "related_resources": {"type": "alias", "path": "referenced_by_documents" }, # alias for referenced_by_documents
                "tags": {"type": "keyword"}
            }
        }
    }

    # Create the index with the specified mappings
    es_client.indices.create(index=index_name, body=body, ignore=400)
    print("Index created successfully.")


def ingest_data(es_client, index_name, data):
    actions = [
        {
            "_index": index_name,
            "_id": doc.id,  # Access attributes using dot notation
            "_source": {
                "title": doc.title,
                "url": doc.url,
                "document_type": doc.document_type,
                "summary": doc.summary,
                "pdf": doc.pdf,
                "pdf_url": doc.pdf_url,
                "source_name": doc.source_name,
                "source_url": doc.source_url,
                "publisher": doc.publisher,
                "publisher_location": doc.publisher_location,
                "volume_count": doc.volume_count,
                "alternate_titles": doc.alternate_titles,
                "alternate_authors": doc.alternate_authors,
                "language": doc.language,
                "popular_count": doc.popular_count,
                "created_at": doc.created_at.isoformat() if doc.created_at else None,
                "updated_at": doc.updated_at.isoformat() if doc.updated_at else None,
                "reference_type": doc.reference_type,
                "published": doc.published,
                "document_style": doc.document_style,
                "alternate_editors": doc.alternate_editors,
                "alternate_translators": doc.alternate_translators,
                "alternate_years": doc.alternate_years,
                "published_at": doc.published_at.isoformat() if doc.published_at else None,
                "citation": doc.citation,
                "gregorian_year": doc.gregorian_year,
                "gregorian_month": doc.gregorian_month,
                "gregorian_day": doc.gregorian_day,
                "reviewed": doc.reviewed,
                "user_full_name": doc.user_full_name,
                "topics": doc.topics,
                "themes": doc.themes,
                "regions": [
                    {
                        "id": region.id,
                        "name": region.name,
                        "hierarchy": region.hierarchy_path
                    }
                    for region in doc.regions
                ],
                "eras": [
                    {
                        "id": era.id,
                        "name": era.name,
                        "hierarchy": era.hierarchy_path
                    }
                    for era in doc.eras
                ],
                "authors": [
                    {
                        "id": author.id,
                        "name": author.name
                    }
                    for author in doc.authors
                ],
                "tags": doc.tags,
                "referenced_by_documents": [
                    {
                        "id": ref_doc['id'],
                        "title": ref_doc['title'],
                        "url": ref_doc['url']
                    }
                    for ref_doc in doc.referenced_by_documents
                ],
                "documents_referenced": [
                    {
                        "id": ref_doc['id'],
                        "title": ref_doc['title'],
                        "url": ref_doc['url']
                    }
                    for ref_doc in doc.documents_referenced
                ]
            }
        }
        for doc in data
    ]
    bulk(es_client, actions)


def main():
    # Connect to the database
    db_connection = DatabaseConnection()
    cursor = db_connection.get_cursor()

    # Fetch all documents from the database
    documents = fetch_all_documents(cursor)

    # Create an Elasticsearch client
    es_client = create_es_client()

    # Create an index in Elasticsearch
    create_index(es_client)

    # Ingest data into Elasticsearch
    ingest_data(es_client, index_name, documents)

    print("Data ingested successfully.")


if __name__ == "__main__":
    main()