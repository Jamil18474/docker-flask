# Étape 1 : Construction des dépendances
FROM python:3.11-alpine AS builder

# Définir des variables d'environnement pour réduire la taille de l'image
ENV PYTHONDONTWRITEBYTECODE=1
ENV PYTHONUNBUFFERED=1

# Définir l'argument APP_VERSION
ARG APP_VERSION=1.0

# Définir un argument pour le nom du fichier requirements
ARG REQUIREMENTS_FILE=requirements.txt

# Créer un répertoire de travail
WORKDIR /app

# Copier le fichier des dépendances
COPY ${REQUIREMENTS_FILE} .

# Installer les dépendances
RUN pip install --no-cache-dir -r ${REQUIREMENTS_FILE}


# Étape 2 : Création de l'image finale
FROM python:3.11-alpine

# Redéfinir l'argument APP_VERSION pour l'étape finale
ARG APP_VERSION=1.0

# Définir des labels
LABEL maintainer="jamil.abdelhamid@ynov.com"
LABEL version="${APP_VERSION}"
LABEL description="Une application web Flask"

# Créer un répertoire de travail
WORKDIR /app

# Copier uniquement les fichiers nécessaires depuis l'étape de construction
COPY --from=builder /usr/local/lib/python3.11/site-packages /usr/local/lib/python3.11/site-packages
COPY . .

# Exposer le port 5000
EXPOSE 5000

# Définir des variables d'environnement pour la configuration de Flask
ENV FLASK_APP=app.py

# Commande pour démarrer l'application
CMD ["python", "-m", "flask", "run", "--host=0.0.0.0"]
