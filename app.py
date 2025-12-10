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

def get_db():
    return mysql.connector.connect(
        host=app.config['MYSQL_HOST'],
        user=app.config['MYSQL_USER'],
        password=app.config['MYSQL_PASSWORD'],
        database=app.config['MYSQL_DB']
    )

@app.route("/register")
def register():
    return render_template('register.html')

@app.route("/register", methods=['POST'])
def register_process():
    if request.method == 'POST':
        name = request.form.get('name')
        email = request.form.get('email')
        password = request.form.get('password')

        cursor.execute('''SELECT * FROM users WHERE email=%s''', (email,))
        existing_user = cursor.fetchone()
        cursor.fetchall() 

        if existing_user:
            return "Email already registered. <a href='/register'>Try again</a>"

        
        cursor.execute('''INSERT INTO users (name, email, password, role) VALUES (%s, %s, %s, %s)''', 
                       (name, email, password, 'member'))
        conn.commit()

        return "Registration successful! <a href='/login'>Login here</a>"

# route login
@app.route("/login")
def login():
    return render_template('login.html')

@app.route("/login", methods=['POST'])
def login_process():
    if request.method == 'POST':
        email = request.form.get('email')
        password = request.form.get('password')

        cursor.execute('''SELECT id, name, role FROM users WHERE email=%s AND password=%s''', (email, password))
        user = cursor.fetchone()
        cursor.fetchall()  

        if user:
            user_id, name, role = user
            session['user_id'] = user_id
            session['user_name'] = name
            session['user_role'] = role
            return redirect('/lens')
        else:
            return "Invalid credentials. <a href='/login'>Try again</a>"


@app.route("/logout")
def logout():
    session.clear()
    return redirect('/login')

@app.route("/lens")
def lens():
    if 'user_id' not in session:
        return redirect('/login')
    return render_template("lens.html")


@app.route("/get-questions")
def get_questions():
    conn = get_db()
    cursor = conn.cursor(dictionary=True)

    cursor.execute("SELECT id, question_text FROM questions ORDER BY id")
    questions = cursor.fetchall()

    cursor.close()
    conn.close()

    return jsonify(questions)


@app.route("/submit-quiz", methods=["POST"])
def submit_quiz():
    data = request.get_json()  
    user_id = session.get("user_id")

    if not user_id:
        return jsonify({"status": "error", "message": "Not logged in"}), 403

    conn = get_db()
    cursor = conn.cursor()

    for question_id, score in data.items():
        cursor.execute(
            "INSERT INTO responses (user_id, question_id, score) VALUES (%s, %s, %s)",
            (user_id, question_id, score)
        )
    conn.commit()
    cursor.close()
    conn.close()

    return jsonify({"status": "success", "message": "Quiz submitted successfully!"})