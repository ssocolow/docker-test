# Start with Node.js base image
FROM node:20-lts

# Set the working directory
WORKDIR /app

# Install Node.js dependencies first
COPY package.json package-lock.json* ./
RUN npm install --save-dev hardhat
RUN npm install express
RUN npm install --save-dev typescript
RUN npm install --save-dev ts-node
# Clone and setup the repository
RUN git clone https://github.com/ssocolow/flare_insure.git
COPY setup.sh ./flare_insure/
WORKDIR /app/flare_insure
RUN chmod +x setup.sh
RUN ./setup.sh

# Return to app directory
WORKDIR /app

# Copy remaining application files
COPY . .

# Return to app directory and expose port
WORKDIR /app
EXPOSE 3003

# Define the command to run the app
CMD ["node", "app.js"]
