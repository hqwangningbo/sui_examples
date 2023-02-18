import { JsonRpcProvider, Network } from '@mysten/sui.js';



const main = async () => {
    // connect to Devnet
    const provider = new JsonRpcProvider(Network.DEVNET);
    // const objects = await provider.getOwnedObjectRefs(
    //     '0xfb4602da6d4d7069e3b129b2dfa6e4a9d8379463',
    // );
    const balance = await provider.getBalance('0xfb4602da6d4d7069e3b129b2dfa6e4a9d8379463','0x2::sui::SUI')
    console.log(balance)

    const devnetEventFilter = {
        All: [
            { EventType: 'MoveEvent' },
            { Package: '0x884b3f3140a7913b4a2f9d49ae147fe90321b82f' },
            { Module: 'first_module' },
        ],
    };
    const devSub = await provider.subscribeEvent(
        devnetEventFilter,
        (event) => {
            // handle subscription notification message here
            console.log(event)
            JSON.stringify()
            console.log(event.event.moveEvent.fields)
            console.log(1)
        },
    );
}

main()