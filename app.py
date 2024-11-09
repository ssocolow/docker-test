# app.py
from flask import Flask

app = Flask(__name__)

@app.route('/info')
def home():
    streakInfo = {"current_streak": 6, "longest_streak": 10, "total_uploads": 23, "last_upload": "Yesterday"}
    return streakInfo

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=3000)

