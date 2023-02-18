import { Ed25519Keypair, JsonRpcProvider, RawSigner,Network } from '@mysten/sui.js';
import {execSync} from 'child_process'

const main = async () => {
    // Generate a new Keypair
    let keypair = Ed25519Keypair.deriveKeypair(process.env.SUI_TEST_SECRET);
    const provider = new JsonRpcProvider(Network.DEVNET);
    const signer = new RawSigner(keypair, provider);
    const compiledModules = JSON.parse(
        execSync(
            `sui move build --dump-bytecode-as-base64 --path fungible_token`,
            { encoding: 'utf-8' },
        ),
    );

    const publishTxn = await signer.publish({
        compiledModules: compiledModules,
        gasBudget: 10000,
    });
    console.log('publishTxn', publishTxn);
}

main()