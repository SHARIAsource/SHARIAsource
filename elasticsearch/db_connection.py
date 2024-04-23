import os
import psycopg
from sshtunnel import SSHTunnelForwarder
from dotenv import load_dotenv

class DatabaseConnection:
    def __init__(self):
        load_dotenv()
        self.server = None
        self.conn = None
        self.setup_ssh_tunnel()
        self.setup_database_connection()

    def setup_ssh_tunnel(self):
        SSH_HOST = os.getenv('SSH_HOST')
        SSH_PORT = int(os.getenv('SSH_PORT', 22))
        SSH_USERNAME = os.getenv('SSH_USERNAME')
        SSH_PRIVATE_KEY_PATH = os.getenv('SSH_PRIVATE_KEY_PATH')
        DB_HOST = os.getenv('DB_HOST')
        DB_PORT = os.getenv('DB_PORT', '5432')

        self.server = SSHTunnelForwarder(
            (SSH_HOST, SSH_PORT),
            ssh_username=SSH_USERNAME,
            ssh_private_key=SSH_PRIVATE_KEY_PATH,
            remote_bind_address=(DB_HOST, int(DB_PORT)),
            local_bind_address=('localhost', 5433)
        )
        self.server.start()
        print(f"SSH tunnel established. Local port: {self.server.local_bind_port}")

    def setup_database_connection(self):
        DB_NAME = os.getenv('DB_NAME')
        DB_USER = os.getenv('DB_USER')
        DB_PASS = os.getenv('DB_PASS')

        try:
            self.conn = psycopg.connect(
                dbname=DB_NAME,
                user=DB_USER,
                password=DB_PASS,
                host='localhost',
                port=self.server.local_bind_port
            )
            print("Database connection established")
        except Exception as e:
            print(f"Error connecting to the database: {e}")
            self.close()

    def get_cursor(self):
        return self.conn.cursor()

    def close(self):
        if self.conn:
            self.conn.close()
            print("Database connection closed")
        if self.server:
            self.server.stop()
            print("SSH tunnel closed")

# This allows the module to be imported without executing any code immediately:
if __name__ == '__main__':
    db = DatabaseConnection()
    cursor = db.get_cursor()
    cursor.execute("SELECT version();")
    version = cursor.fetchone()
    print(f"Database version: {version}")
    cursor.close()
    db.close()
