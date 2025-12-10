from flask import Flask, jsonify, render_template, request, redirect, session
from dotenv import load_dotenv
import os
import mysql.connector

app = Flask(__name__) 

app.secret_key = os.getenv('SECRET_KEY')

app.config['MYSQL_HOST'] = os.getenv('MYSQL_HOST')
app.config['MYSQL_USER'] = os.getenv('MYSQL_USER')
app.config['MYSQL_PASSWORD'] = os.getenv('MYSQL_PASSWORD')
app.config['MYSQL_DB'] = os.getenv('MYSQL_DB')

conn = mysql.connector.connect(
host=app.config['MYSQL_HOST'],
user=app.config['MYSQL_USER'],
password=app.config['MYSQL_PASSWORD'],
database=app.config['MYSQL_DB']
)


cursor = conn.cursor()

@app.route("/lens")
def lens():
    if 'user_id' not in session:
        return redirect('/login')

   
    cursor.execute('''SELECT id, question_text, category_id
                      FROM questions
                      WHERE category_id = %s
                      ORDER BY id''', (1,))
    questions = cursor.fetchall()

    return render_template('lens.html', questions=questions)