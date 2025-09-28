/**
 *Submitted for verification at basescan.org on 2025-01-16
*/

// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract RocketMechanic {
    // États de la fusée
    string public engineType;
    uint public nitroAmount;
    bool public isMoonModeOn;
    uint public engineUpgradeLevel;

    // Événements pour suivre les actions effectuées par le mécanicien
    event EngineChanged(string newEngine);
    event NitroAdded(uint amount);
    event MoonModeInstalled(bool state);
    event EngineUpgraded(uint level);

    // Constructeur pour initialiser les paramètres de la fusée
    constructor() {
        engineType = "Standard";
        nitroAmount = 0;
        isMoonModeOn = false;
        engineUpgradeLevel = 0;
    }

    // Fonction pour changer le moteur de la fusée
    function changeEngine(string memory newEngineType) public {
        engineType = newEngineType;
        emit EngineChanged(newEngineType);
    }

    // Fonction pour ajouter une quantité aléatoire de nitro
    function addNitro() public {
        nitroAmount = uint(keccak256(abi.encodePacked(block.timestamp, block.prevrandao))) % 101; // Quantité entre 0 et 100
        emit NitroAdded(nitroAmount);
    }

    // Fonction pour installer le mode "Moon"
    function installMoonMode() public {
        isMoonModeOn = true;
        emit MoonModeInstalled(isMoonModeOn);
    }

    // Fonction pour effectuer une amélioration aléatoire du moteur
    function upgradeEngine() public {
        uint randomUpgrade = uint(keccak256(abi.encodePacked(block.timestamp, block.prevrandao))) % 11; // Amélioration entre 0 et 10
        engineUpgradeLevel += randomUpgrade;
        emit EngineUpgraded(engineUpgradeLevel);
    }

    // Fonction pour obtenir l'état complet de la fusée
    function getRocketStatus() public view returns (string memory) {
        string memory moonModeStatus = isMoonModeOn ? "active" : "inactive";
        return string(abi.encodePacked(
            "Moteur: ", engineType, ", Nitro: ", uintToString(nitroAmount), ", Mode Moon: ", moonModeStatus, ", Niveau d'amelioration: ", uintToString(engineUpgradeLevel)
        ));
    }

    // Fonction utilitaire pour convertir un uint en string
    function uintToString(uint v) internal pure returns (string memory) {
        if (v == 0) {
            return "0";
        }
        uint maxLen = 100;
        bytes memory reversed = new bytes(maxLen);
        uint i = 0;
        while (v != 0) {
            uint remainder = v % 10;
            v = v / 10;
            reversed[i++] = bytes1(uint8(48 + remainder));
        }
        bytes memory s = new bytes(i);
        for (uint j = 0; j < i; j++) {
            s[j] = reversed[i - 1 - j];
        }
        return string(s);
    }
}
