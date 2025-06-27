# Etapa de construcción
FROM node:22 AS build-stage
WORKDIR /app

# Copiar package.json y package-lock.json
COPY package*.json ./

# Instalar dependencias
RUN npm install

# Copiar el resto del código fuente
COPY . .

# Si usas TypeScript, descomenta esta línea:
# RUN npm run build

# Etapa final: Producción
FROM node:22 AS production-stage
WORKDIR /app

# Copiar todo desde la etapa anterior
COPY --from=build-stage /app /app

# Expone el puerto 3000
EXPOSE 3001

# Comando de inicio: ejecuta src/index.js
CMD ["node", "src/index.js"]
