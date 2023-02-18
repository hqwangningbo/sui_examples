import {Ed25519Keypair, JsonRpcProvider, Network, RawSigner} from '@mysten/sui.js';

const callEntry = async () => {
    // connect to Devnet
    const provider = new JsonRpcProvider(Network.DEVNET);

    // Generate a new Keypair
    let keypair = Ed25519Keypair.deriveKeypair("peasant civil girl twin shield virtual soul annual physical dice cruel shove");
    const signer = new RawSigner(keypair, provider);
    const moveCallTxn = await signer.executeMoveCall({
        packageObjectId: '0x884b3f3140a7913b4a2f9d49ae147fe90321b82f',
        module: 'first_module',
        function: 'create_name_card',
        typeArguments: [],
        arguments: [
            'Name',
            18,
            'Tom Tom',
        ],
        gasBudget: 10000,
    });
    console.log('moveCallTxn', moveCallTxn);
}

const callPublic = async () => {
    // connect to Devnet
    const provider = new JsonRpcProvider(Network.DEVNET);

    // Generate a new Keypair
    let keypair = Ed25519Keypair.deriveKeypair("");
    const signer = new RawSigner(keypair, provider);
    const moveCallTxn = await signer.executeMoveCall({
        packageObjectId: '0x884b3f3140a7913b4a2f9d49ae147fe90321b82f',
        module: 'first_module',
        function: 'create_name_card',
        typeArguments: [],
        arguments: [
            'Name',
            18,
            'Tom Tom',
        ],
        gasBudget: 10000,
    });
    console.log('moveCallTxn', moveCallTxn);
}

main()