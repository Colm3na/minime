
//File: ./contracts/Controlled.sol
pragma solidity ^0.4.18;

contract Controlled {
    /// @notice La dirección del controlador es la única dirección que puede
    ///  llamar a una función con este modificador
    modifier onlyController { require(msg.sender == controller); _; }

    address public controller;

    function Controlled() public { controller = msg.sender;}

    /// @notice Cambia el controlador del contrato
    /// @param _newController El nuevo controlador del contrato
    function changeController(address _newController) public onlyController {
        controller = _newController;
    }
}
