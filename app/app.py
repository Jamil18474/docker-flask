from flask import Flask # Importation de Flask pour créer l'application

app = Flask(__name__)  # Création d'une instance de l'application Flask

@app.route('/')
def hello_world():  # Route principale de l'application
    """Retourne un message de bienvenue."""
    return 'Hello World!'  # Réponse simple pour la route principale

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=5000)  # Démarre l'application Flask en écoutant sur toutes les interfaces réseau