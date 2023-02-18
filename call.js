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

const callMint = async () => {
    // connect to Devnet
    const provider = new JsonRpcProvider(Network.DEVNET);

    // Generate a new Keypair
    let keypair = Ed25519Keypair.deriveKeypair(process.env.SUI_TEST_SECRET);
    const signer = new RawSigner(keypair, provider);
    const moveCallTxn = await signer.executeMoveCall({
        packageObjectId: '0x7816adf1fbdbb3355fca9ff37f6046f84b61582b',
        module: 'nb',
        function: 'mint',
        typeArguments: [],
        arguments: [
            "0x33949653654299c0f9320ad5c7c0d8eab83e1c6b",
            "100000000000",
            "0xe458463c0e55b96c4b386fe5ae3767228c34511e"
        ],
        gasBudget: 10000,
    });
    console.log('moveCallTxn', moveCallTxn);
}

callMint()

