# Étape 1 : Construction des dépendances
# Utilise l'image Python 3.11 basée sur Alpine pour la construction
FROM python:3.11-alpine AS builder

# Définir des variables d'environnement pour réduire la taille de l'image
# Empêche Python d'écrire des fichiers .pyc (bytecode) sur le disque
ENV PYTHONDONTWRITEBYTECODE=1
# Assure que les sorties de Python sont immédiatement affichées dans le terminal
ENV PYTHONUNBUFFERED=1

# Version de l'application, peut être modifiée lors de la construction de l'image
ARG APP_VERSION=1.0

# Définir un argument pour le nom du fichier requirements contenant les dépendances Python
ARG REQUIREMENTS_FILE=requirements.txt

# Définit le répertoire de travail à /app
WORKDIR /app

# Copie le fichier requirements.txt dans le répertoire de travail
COPY ${REQUIREMENTS_FILE} .

# Installe les dépendances sans utiliser le cache pour réduire la taille de l'image
RUN pip install --no-cache-dir -r ${REQUIREMENTS_FILE}

# Étape 2 : Création de l'image finale
# Utilise à nouveau l'image Python 3.11 basée sur Alpine pour l'image finale
FROM python:3.11-alpine

# Redéfinir l'argument APP_VERSION pour l'étape finale
ARG APP_VERSION=1.0

# Définit un label pour la version de l'image
LABEL version="${APP_VERSION}"

# Définit un label pour décrire l'image
LABEL description="Une application web Flask"

# Définit le répertoire de travail à /app
WORKDIR /app

# Copier uniquement les fichiers nécessaires depuis l'étape de construction
COPY --from=builder /usr/local/lib/python3.11/site-packages /usr/local/lib/python3.11/site-packages

# Copie le fichier app.py dans le répertoire de travail
COPY app.py .

# Expose le port 5000 pour que l'application Flask soit accessible
EXPOSE 5000

# Définit le point d'entrée de l'application Flask
ENV FLASK_APP=app.py

# Commande pour démarrer l'application
CMD ["python", "-m", "flask", "run", "--host=0.0.0.0"]

