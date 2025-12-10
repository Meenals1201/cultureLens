from flask import Flask, jsonify, render_template, request
from dotenv import load_dotenv
import os
import mysql.connector

app = Flask(__name__) 

