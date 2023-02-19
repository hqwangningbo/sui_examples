module fungible_token::nb {
    use sui::tx_context::TxContext;
    use sui::coin;
    use std::option;
    use sui::url::{new_unsafe_from_bytes, Url};
    use sui::transfer;
    use sui::tx_context;
    use sui::coin::{TreasuryCap, Coin};
    #[test_only]
    use sui::test_scenario;

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

    #[test]
    fun test_coin(){
        let admin = @0x001;
        let user = @0x002;
        let scenario_val = test_scenario::begin(admin);
        let scenario = &mut scenario_val;
        {
            let ctx = test_scenario::ctx(scenario);
            init(NB{},ctx)
        };
        test_scenario::next_tx(scenario,admin);
        {
            let treasury_cap = test_scenario::take_from_sender<TreasuryCap<NB>>(scenario);
            let ctx = test_scenario::ctx(scenario);
            mint(&mut treasury_cap,100,admin,ctx);
            test_scenario::return_to_sender(scenario,treasury_cap);
        };
        test_scenario::next_tx(scenario,admin);
        {
            let nb = test_scenario::take_from_sender<Coin<NB>>(scenario);
            let ctx = test_scenario::ctx(scenario);
            assert!(coin::value(&nb) == 100 , 0);
            let nb_10 = coin::split(&mut nb,10,ctx);
            transfer::transfer(nb_10,user);
            assert!(coin::value(&nb) == 90 , 0);
            test_scenario::return_to_sender(scenario, nb);
        };
        test_scenario::next_tx(scenario,user);
        {
            let nb = test_scenario::take_from_sender<Coin<NB>>(scenario);
            assert!(coin::value(&nb) == 10 , 0);
            test_scenario::return_to_sender(scenario,nb);
        };
        test_scenario::end(scenario_val);
    }
}

