import { JsonRpcProvider, Network } from '@mysten/sui.js';

const main = async () => {
    // connect to Devnet
    const provider = new JsonRpcProvider(Network.DEVNET);
    const txEvents = await provider.getEvents(
        { Transaction: "8AwfCNaprHgkpYqas6DhjmfYfNAwHsU3n2kKwAPHK9b6" }
    );

    console.log(txEvents.data[0].event)
}

main()