# Step 1: Use a base image with both Python and git
FROM python:3.9-slim

# Step 2: Install necessary packages including git, curl, and node
RUN apt-get update && apt-get install -y \
    git \
    curl \
    && rm -rf /var/lib/apt/lists/*

# Step 3: Install Node.js and npm
RUN curl -fsSL https://deb.nodesource.com/setup_18.x | bash - \
    && apt-get install -y nodejs \
    && npm install -g npm@latest

# Step 4: Set the working directory
WORKDIR /app

# Step 5: Clone your git repository
# Replace the URL with your actual repository URL
RUN git clone https://github.com/your-repo-url.git .

# Step 6: Copy the requirements file and install Python dependencies
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# Step 7: Install hardhat and project dependencies
RUN npm install --save-dev hardhat

# Step 8: Install Express
RUN npm install express

# Step 9: Copy application files
COPY . .

# Step 10: Run your setup script
# Make sure the script is executable
COPY setup.sh .
RUN chmod +x setup.sh
RUN ./setup.sh

# Step 9: Expose the port the app will run on
EXPOSE 3000

# Step 10: Define the command to run the app
CMD ["node", "app.js"]
