import json
from flask import Flask, render_template, request
from datetime import date
import psycopg2
import os

app = Flask(__name__)

@app.route('/')
def get_visitors():        
    try:
        host = request.remote_addr
        ua = request.headers.get('User-Agent')
        today = date.today()
        insert_sql = "INSERT INTO visits_log(user_agent,request_ip,created_on) VALUES (%s,%s,%s);"
        insert_data = (ua,host,today)
        connection = psycopg2.connect(database=os.getenv("DB_DATABASE"),user=os.getenv("DB_USER"),password=os.getenv("DB_PASSWORD"),host=os.getenv("DB_HOST"), port=os.getenv("DB_PORT"))
        cursor = connection.cursor() 
        cursor.execute(insert_sql,insert_data)
        connection.commit()
        cursor.execute("SELECT COUNT(DISTINCT request_ip) FROM visits_log")
        data = cursor.fetchall() 
        return render_template('index.html', data=data)
    except (Exception, psycopg2.Error) as error:
        print("Failed to insert record into table", error)
    finally:
        if connection:
            cursor.close()
            connection.close()
            print("PostgreSQL connection is closed")

@app.route('/version')
def get_version():    
    app_name = "Check Visitors"
    app_version = 1.0
    language_name = "Python"
    language_version = "3.9.2"   
    version = {
        "app_name": app_name,
        "app_version": app_version,
        "language_name": language_name,
        "language_version": language_version
    }
    return json.dumps(version)


if __name__ == "__main__":
    app.run()