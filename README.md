![MiniMe Token](readme-header.png)

[![Build Status](https://travis-ci.org/Giveth/minime.svg?branch=master)](https://travis-ci.org/Giveth/minime)

El contrato MiniMeToken es un estándar ERC20 con algunas funcionalidades extra:

### El token es fácil de clonar!
Cualquiera puede crear un nuevo clon del token a partir de cualquier token utilizando este contrato con una distribución inicial idéntica al token original en un bloque específico. La dirección que llama a la función `createCloneToken` se convertirá en el controlador de tokens y los ajustes predeterminados del token se pueden especificar en la llamada de función.

    function createCloneToken(
        string _cloneTokenName,
        uint8 _cloneDecimalUnits,
        string _cloneTokenSymbol,
        uint _snapshotBlock,
        bool _isConstant
        ) returns(address) {

Una vez creado el token de clonación, actúa como un token completamente independiente, con sus propias funcionalidades únicas.

### El balance del saldo está registrado y disponible para ser consultado.

Todos los MiniMe Tokens mantienen un historial de los cambios de balance que ocurren durante cada bloque. Se introducen dos llamadas para leer el totalSupply y el balance de cualquier dirección en cualquier bloque en el pasado.

    function totalSupplyAt(uint _blockNumber) constant returns(uint)

    function balanceOfAt(address _holder, uint _blockNumber) constant returns (uint)

### Controlador de tokens opcional

El controlador del contrato puede generar/destruir/transferir tokens a su propia voluntad. El controlador puede ser una cuenta normal, pero la intención es que el controlador sea otro contrato que imponga reglas transparentes sobre la emisión y funcionalidad del token. El controlador de tokens no es necesario para que el token MiniMe funcione, si no hay razón para generar/destruir/transferir tokens, el controlador de tokens puede configurarse en 0x0 y esta funcionalidad se desactivará.

Por ejemplo, un contrato de creación de tokens puede configurarse como controlador del token MiniMe y al final del período de creaciń de tokens, el controlador puede transferirse a la dirección 0x0, para garantizar que no se crearán nuevos tokens

Para crear y destruir tokens, se introducen estas dos funciones:

    function generateTokens(address _holder, uint _value) onlyController

    function destroyTokens(address _holder, uint _value) onlyController

### El controlador del token puede congelar las transferencias.

Si transfersEnabled == false, los tokens no pueden ser transferidos por los usuarios, sin embargo, pueden ser creados, destruidos y transferidos por el controlador. El controlador también puede cambiar esta opción.

    // Allows tokens to be transferred if true or frozen if false
    function enableTransfers(bool _transfersEnabled) onlyController


## Aplicaciones

Si este contrato de token se usa como token base, entonces los clones de sí mismos pueden ser fácilmente generados en cualquier  número de bloque dado, esto permite una funcionalidad increíblemente poderosa, efectivamente la habilidad de cualquiera de dar características extra a los poseedores de tokens sin tener que migrar a un nuevo contrato. Algunas de las aplicaciones para las que se puede utilizar el contrato del token MiniMe son:

1. Generar un token de votación que se quema cuando se vota.
2. Generar un "cupón" de descuento que se canjea cuando se utiliza.
3. Generación de un token para un derivado de DAO.
4. Generación de un token que puede ser utilizado para dar apoyo explícito a una acción o campaña, como el sondeo.
5. Generación de un token para que los titulares del token puedan cobrar los pagos diarios, mensuales o anuales.
6. Generación de un token para limitar la participación en una venta de token o evento similar a los titulares de un token específico.
7. Generación de tokens que permite a un grupo central control total para transferir/generar/destruir tokens a voluntad.
8. Muchas otras aplicaciones, incluyendo todas las aplicaciones para las que se pueden utilizar el token ERC20 estándar.

Todas estas aplicaciones y más están habilitadas por el contrato MiniMe token. La parte más asombrosa es que cualquiera que quiera añadir estas características puede hacerlo, de una manera segura y sin permisos sin afectar a la funcionalidad prevista del token padre.

# Cómo desplegar una campaña

1. Desplegar MiniMeTokenFactory
2. Desplegar el MinimeToken
3. Desplegar la campaña
4. Asigne el controlador del MinimeToken a la campaña


