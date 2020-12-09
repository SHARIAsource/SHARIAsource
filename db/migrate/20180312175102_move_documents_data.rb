class MoveDocumentsData < ActiveRecord::Migration[5.1]
  def change
    execute <<-SQL
      -- Moving authors data
      CREATE OR REPLACE FUNCTION
      create_author(FUNC_ID integer, FUNC_NAME text)
      RETURNS void
      AS $$
      DECLARE
      A_ID integer;
      BEGIN
        IF EXISTS(SELECT 1 FROM authors WHERE name = FUNC_NAME) THEN
          SELECT id FROM authors WHERE name = FUNC_NAME INTO A_ID;
        ELSE
          INSERT INTO authors (name) VALUES (FUNC_NAME)
          RETURNING id INTO A_ID;
        END IF;

        INSERT INTO authors_documents (document_id, author_id) VALUES (FUNC_ID, A_ID);
      END $$ LANGUAGE plpgsql;

      SELECT create_author(id::integer, author::text) FROM documents WHERE author != '';

      DROP FUNCTION create_author(FUNC_ID integer, FUNC_NAME text);

      -- Moving editors data
      CREATE OR REPLACE FUNCTION
      create_editor(FUNC_ID integer, FUNC_NAME text)
      RETURNS void
      AS $$
      DECLARE
      A_ID integer;
      BEGIN
        IF EXISTS(SELECT 1 FROM editors WHERE name = FUNC_NAME) THEN
          SELECT id FROM editors WHERE name = FUNC_NAME INTO A_ID;
        ELSE
          INSERT INTO editors (name) VALUES (FUNC_NAME)
          RETURNING id INTO A_ID;
        END IF;

        INSERT INTO documents_editors (document_id, editor_id) VALUES (FUNC_ID, A_ID);
      END $$ LANGUAGE plpgsql;

      SELECT create_editor(id::integer, editors::text) FROM documents WHERE editors != '';

      DROP FUNCTION create_editor(FUNC_ID integer, FUNC_NAME text);

      -- Moving translators data
      CREATE OR REPLACE FUNCTION
      create_translator(FUNC_ID integer, FUNC_NAME text)
      RETURNS void
      AS $$
      DECLARE
      A_ID integer;
      BEGIN
        IF EXISTS(SELECT 1 FROM translators WHERE name = FUNC_NAME) THEN
          SELECT id FROM translators WHERE name = FUNC_NAME INTO A_ID;
        ELSE
          INSERT INTO translators (name) VALUES (FUNC_NAME)
          RETURNING id INTO A_ID;
        END IF;

        INSERT INTO documents_translators (document_id, translator_id) VALUES (FUNC_ID, A_ID);
      END $$ LANGUAGE plpgsql;

      SELECT create_translator(id::integer, translators::text) FROM documents WHERE translators != '';

      DROP FUNCTION create_translator(FUNC_ID integer, FUNC_NAME text);

      -- Moving contributors data
      INSERT INTO contributors_documents (document_id, contributor_id)
      SELECT id, contributor_id FROM documents;
    SQL
  end
end
