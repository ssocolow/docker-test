echo "Installing dependencies..."
npm install
source .env
echo "Running Hardhat..."
npx hardhat compile
echo "Hardhat compilation complete"