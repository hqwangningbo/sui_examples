module sui::kitty {
    use sui::url::{Self, Url};
    use std::string;
    use sui::object::{Self, ID, UID};
    use sui::event;
    use sui::transfer;
    use sui::tx_context::{Self, TxContext};
    #[test_only]
    use sui::test_scenario;
    
    struct Kitty has key, store {
        id: UID,
        name: string::String,
        description: string::String,
        url: Url,
    }

    struct MintNFTEvent has copy, drop {
        // The Object ID of the NFT
        object_id: ID,
        // The creator of the NFT
        creator: address,
        // The name of the NFT
        name: string::String,
    }

    /// Create a new kitty
    public entry fun mint(
        name: vector<u8>,
        description: vector<u8>,
        url: vector<u8>,
        ctx: &mut TxContext
    ) {
        let nft = Kitty {
            id: object::new(ctx),
            name: string::utf8(name),
            description: string::utf8(description),
            url: url::new_unsafe_from_bytes(url)
        };
        let sender = tx_context::sender(ctx);
        event::emit(MintNFTEvent {
            object_id: object::uid_to_inner(&nft.id),
            creator: sender,
            name: nft.name,
        });
        transfer::transfer(nft, sender);
    }

    /// Update the `description` of `nft` to `new_description`
    public entry fun update_description(
        nft: &mut Kitty,
        new_description: vector<u8>,
    ) {
        nft.description = string::utf8(new_description)
    }

    /// Permanently delete `nft`
    public entry fun burn(nft: Kitty) {
        let Kitty { id, name: _, description: _, url: _ } = nft;
        object::delete(id)
    }

    /// Get the NFT's `name`
    public fun name(nft: &Kitty): &string::String {
        &nft.name
    }

    /// Get the NFT's `description`
    public fun description(nft: &Kitty): &string::String {
        &nft.description
    }

    /// Get the NFT's `url`
    public fun url(nft: &Kitty): &Url {
        &nft.url
    }

    #[test]
    fun mint_transfer_update() {
        let addr1 = @0xA;
        let addr2 = @0xB;
        // create the NFT
        let scenario = test_scenario::begin(addr1);
        {
            mint(b"test", b"a test", b"https://www.sui.io", test_scenario::ctx(&mut scenario))
        };
        // send it from A to B
        test_scenario::next_tx(&mut scenario, addr1);
        {
            let nft = test_scenario::take_from_sender<Kitty>(&mut scenario);
            transfer::transfer(nft, addr2);
        };
        // update its description
        test_scenario::next_tx(&mut scenario, addr2);
        {
            let nft = test_scenario::take_from_sender<Kitty>(&mut scenario);
            update_description(&mut nft, b"a new description") ;
            assert!(*string::bytes(description(&nft)) == b"a new description", 0);
            test_scenario::return_to_sender(&mut scenario, nft);
        };
        // burn it
        test_scenario::next_tx(&mut scenario, addr2);
        {
            let nft = test_scenario::take_from_sender<Kitty>(&mut scenario);
            burn(nft)
        };
        test_scenario::end(scenario);
    }
}
