#!/usr/bin/python3
"""
start Flask application
"""

from flask import Flask
app = Flask(__name__)

@app.route('/airbnb-onepage/', strict_slashes=False)
def airbnb_onepage():
    """returns Hello HBNB!"""
    return 'Hello from Airbnb Onepage!'
# Add a route for the version without a trailing slash to redirect to the one with a trailing slash
@app.route('/airbnb-onepage')
def redirect_airbnb_onepage():
    return redirect(url_for('airbnb_onepage'), code=301)

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=5000)
