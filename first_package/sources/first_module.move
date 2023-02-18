module first_package::first_module {
    use sui::object::UID;
    use std::string::String;
    use sui::tx_context::TxContext;
    use sui::transfer;
    use sui::object;
    use std::string;
    use sui::tx_context;
    use sui::event;

    struct NameCard has key, store {
        id : UID,
        name: String,
        address: address,
        gender: u8,
        is_exist: bool ,
        description: String
    }

    struct CreateEvent has copy,drop {
        creator: address,
        name: String
    }

    fun init(ctx: &mut TxContext) {
        let nameCard = NameCard {
            id : object::new(ctx),
            name: string::utf8(b"nb"),
            address: tx_context::sender(ctx),
            gender: 1,
            is_exist: true,
            description: string::utf8(b"Admin")
        };
        transfer::transfer(nameCard,tx_context::sender(ctx))
    }

    public fun name(self : &NameCard) : String {
        self.name
    }

    public fun gender(self : &NameCard) : u8 {
        self.gender
    }

    public fun is_exist(self : &NameCard) : bool {
        self.is_exist
    }

    public fun description(self : &NameCard) : String {
        self.description
    }

    public entry fun create_name_card(name:String,gender:u8,description:String,ctx:&mut TxContext){
        let name_card = NameCard {
            id : object::new(ctx),
            name,
            address:tx_context::sender(ctx),
            gender,
            is_exist:true,
            description
        };
        transfer::transfer(name_card,tx_context::sender(ctx));
        event::emit(
            CreateEvent {
                creator:tx_context::sender(ctx),
                name
            }
        );
    }
}