#!/bin/bash
# Add your bash commands here
source .env
npx hardhat run scripts/FDCExampleJqFirstHalf.ts --network coston2
echo "about to sleep"
sleep 150
npx hardhat run scripts/FDCExampleJqSecondHalf.ts --network coston2
echo "Script done executing"
echo "Script executed at $(date)"
# Add your commands here 