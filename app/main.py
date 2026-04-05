from flask import Flask, request, jsonify

app = Flask(__name__)

@app.route('/shorten', methods=['POST'])
def shorten():
    data = request.get_json()
    url = data.get('url')
    # כאן יבוא הלוגיקה של קיצור הלינק
    return jsonify({"short_url": f"http://short.ly/abc123", "original_url": url}), 201

@app.route('/health', methods=['GET'])
def health():
    return jsonify({"status": "healthy"}), 200

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=5000)