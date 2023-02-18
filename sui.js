import { JsonRpcProvider, Network } from '@mysten/sui.js';



const main = async () => {
    // connect to Devnet
    const provider = new JsonRpcProvider(Network.DEVNET);
    // const objects = await provider.getOwnedObjectRefs(
    //     '0xfb4602da6d4d7069e3b129b2dfa6e4a9d8379463',
    // );
    const balance = await provider.getBalance('0xfb4602da6d4d7069e3b129b2dfa6e4a9d8379463','0x2::sui::SUI')
    console.log(balance)

    const objects = await provider.getObjectsOwnedByAddress('0xfb4602da6d4d7069e3b129b2dfa6e4a9d8379463');
    console.log(objects)

    const o = await provider.getObject("0xe90d02e05d69ad92e52e314522b4c33070a3b8ea")
    console.log(o)
}

main()