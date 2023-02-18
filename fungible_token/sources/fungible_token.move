module fungible_token::nb {
    use sui::tx_context::TxContext;
    use sui::coin;
    use std::option;
    use sui::url::{new_unsafe_from_bytes, Url};
    use sui::transfer;
    use sui::tx_context;
    use sui::coin::{TreasuryCap, Coin};

    struct NB has drop { }

    fun init( witness: NB , ctx:&mut TxContext){
        //decimals: u8,
        //symbol: vector<u8>,
        //name: vector<u8>,
        //description: vector<u8>,
        //icon_url: Option<Url>,
        let (treasury_cap,coin_metadata) = coin::create_currency<NB>(
            witness,
            9,
            b"NB",
            b"NB COIN",
            b"NB",
            option::some<Url>(new_unsafe_from_bytes(b"https://avatars.githubusercontent.com/u/57781136?s=40&v=4")),
            ctx
        );
        transfer::freeze_object(coin_metadata);
        transfer::transfer(treasury_cap,tx_context::sender(ctx));
    }

    public entry fun mint(
        treasury_cap:&mut TreasuryCap<NB>,
        amount:u64,
        receiver:address,
        ctx:&mut TxContext
    ){
        coin::mint_and_transfer(treasury_cap,amount,receiver,ctx);
    }

    public entry fun burn(
        treasury_cap:&mut TreasuryCap<NB>,
        coin:Coin<NB>
    ){
        coin::burn(
            treasury_cap,
            coin
        );
    }
}