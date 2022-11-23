module pancake::router {
    use aptos_framework::coin::Coin;
    use aptos_framework::coin;
    use pancake::swap;
    use pancake::swap_utils;

    public fun swap_exact_x_to_y_direct_external<X, Y>(x_in: Coin<X>): Coin<Y>{
        coin::destroy_zero(x_in);
        coin::zero<Y>()
    }

    /// Added by hippo
    public fun get_amount_out<InputCoin, OutputCoint>(amount_in: u64, is_forward: bool): u64 {
        if (is_forward){
            let (rin, rout, _) = swap::token_reserves<InputCoin, OutputCoint>();
            swap_utils::get_amount_out(amount_in, rin, rout)
        } else {
            let (rout, rin, _) = swap::token_reserves<InputCoin, OutputCoint>();
            swap_utils::get_amount_out(amount_in, rin, rout)
        }
    }
}
