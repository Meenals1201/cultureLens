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
@app.route("/")
def login():
    return render_template('login.html')

@app.route("/", methods=['POST'])
def login_process():
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

        if role == 'admin':
            return redirect('/admin-page')
        else:
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
    user_id = session.get("user_id")
    if not user_id:
        return redirect('/login')

    
    answers = request.form  

    conn = get_db()
    cursor = conn.cursor()

    
    for question_id, score in answers.items():
        cursor.execute(
            "INSERT INTO responses (user_id, question_id, score) VALUES (%s, %s, %s)",
            (user_id, question_id, score)
        )
    conn.commit()

    
    cursor.execute("""
        SELECT q.category_id, SUM(r.score) as total_score
        FROM responses r
        JOIN questions q ON r.question_id = q.id
        WHERE r.user_id = %s
        GROUP BY q.category_id
        ORDER BY total_score DESC
        LIMIT 1
    """, (user_id,))
    top_category = cursor.fetchone()
    if not top_category:
        return "No answers found for user."

    category_id, total_score = top_category

    cursor.execute("SELECT category_name FROM categories WHERE id=%s", (category_id,))
    category_name = cursor.fetchone()[0]

    cursor.execute("""
        SELECT name, about, application_link
        FROM organisations
        WHERE category_id=%s
    """, (category_id,))
    organisations = cursor.fetchall()

    cursor.close()
    conn.close()

    return render_template(
        "results.html",
        category_name=category_name,
        total_score=total_score,
        organisations=organisations
    )

@app.route("/admin-page")
def admin_page():
    if 'user_id' in session and session['user_role'] == 'admin':
        conn = get_db()
        cursor = conn.cursor(dictionary=True)

        cursor.execute("SELECT * FROM questions")
        questions = cursor.fetchall()

        cursor.execute("SELECT * FROM categories")
        categories = cursor.fetchall()

        cursor.close()
        conn.close()

        return render_template("admin-dashboard.html", questions=questions, categories=categories)
    else:
        return "Access denied. Admins only."

@app.route("/admin/categories")
def admin_categories():
    if 'user_id' in session and session['user_role'] == 'admin':
        cursor.execute('''SELECT * FROM categories''')
        categories = cursor.fetchall()
        return render_template('admin-categories.html', categories=categories)
    else:
        return "Access denied. Admins only."

@app.route("/admin/add-category")
def add_category():
    if 'user_id' in session and session['user_role'] == 'admin':
        return render_template('add-category.html')
    else:
        return "Access denied. Admins only."

@app.route("/admin/add-category", methods=['POST'])
def add_category_process():
    if 'user_id' in session and session['user_role'] == 'admin':
        name = request.form.get('name')
        cursor.execute('''INSERT INTO categories (category_name) VALUES (%s)''', (name,))
        conn.commit()
        return redirect('/admin/categories')
    else:
        return "Access denied. Admins only."

@app.route("/admin/edit-category/<id>")
def edit_category(id):
    if 'user_id' in session and session['user_role'] == 'admin':
        cursor.execute('''SELECT * FROM categories WHERE id=%s''', (id,))
        category = cursor.fetchone()
        return render_template('edit-category.html', category=category)
    else:
        return "Access denied. Admins only."

@app.route("/admin/edit-category/<id>", methods=['POST'])
def edit_category_process(id):
    if 'user_id' in session and session['user_role'] == 'admin':
        name = request.form.get('name')
        cursor.execute('''UPDATE categories SET category_name=%s WHERE id=%s''', (name, id))
        conn.commit()
        return redirect('/admin/categories')
    else:
        return "Access denied. Admins only."

@app.route("/admin/delete-category/<id>")
def delete_category(id):
    if 'user_id' in session and session['user_role'] == 'admin':
        cursor.execute('''DELETE FROM categories WHERE id=%s''', (id,))
        conn.commit()
        return redirect('/admin/categories')
    else:
        return "Access denied. Admins only."


@app.route("/admin/questions")
def admin_questions():
    if 'user_id' in session and session['user_role'] == 'admin':
        cursor.execute('''SELECT q.id, q.question_text, c.category_name 
                          FROM questions q 
                          JOIN categories c ON q.category_id=c.id''')
        questions = cursor.fetchall()
        return render_template('admin-questions.html', questions=questions)
    else:
        return "Access denied. Admins only."

@app.route("/admin/add-question")
def add_question():
    if 'user_id' in session and session['user_role'] == 'admin':
        cursor.execute('''SELECT * FROM categories''')
        categories = cursor.fetchall()
        return render_template('add-question.html', categories=categories)
    else:
        return "Access denied. Admins only."

@app.route("/admin/add-question", methods=['POST'])
def add_question_process():
    if 'user_id' in session and session['user_role'] == 'admin':
        text = request.form.get('question_text')
        category_id = request.form.get('category_id')
        cursor.execute('''INSERT INTO questions (question_text, category_id) VALUES (%s,%s)''', (text, category_id))
        conn.commit()
        return redirect('/admin/questions')
    else:
        return "Access denied. Admins only."

@app.route("/admin/edit-question/<id>")
def edit_question(id):
    if 'user_id' in session and session['user_role'] == 'admin':
        cursor.execute('''SELECT * FROM questions WHERE id=%s''', (id,))
        question = cursor.fetchone()
        cursor.execute('''SELECT * FROM categories''')
        categories = cursor.fetchall()
        return render_template('edit-question.html', question=question, categories=categories)
    else:
        return "Access denied. Admins only."

@app.route("/admin/edit-question/<id>", methods=['POST'])
def edit_question_process(id):
    if 'user_id' in session and session['user_role'] == 'admin':
        text = request.form.get('question_text')
        category_id = request.form.get('category_id')
        cursor.execute('''UPDATE questions SET question_text=%s, category_id=%s WHERE id=%s''', (text, category_id, id))
        conn.commit()
        return redirect('/admin/questions')
    else:
        return "Access denied. Admins only."

@app.route("/admin/delete-question/<id>")
def delete_question(id):
    if 'user_id' in session and session['user_role'] == 'admin':
        cursor.execute('''DELETE FROM questions WHERE id=%s''', (id,))
        conn.commit()
        return redirect('/admin/questions')
    else:
        return "Access denied. Admins only."


