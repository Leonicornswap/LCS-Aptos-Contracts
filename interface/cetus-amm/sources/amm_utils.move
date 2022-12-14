module cetus_amm::amm_utils {
    use std::error;
    use cetus_amm::amm_math;

    const ESWAP_COIN_NOT_EXISTS: u64 = 5001;
    const EPARAMETER_INVALID: u64 = 5002;

    public fun get_amount_out(
        amount_in: u128,
        reserve_in: u128,
        reserve_out: u128,
        fee_numerator: u64,
        fee_denumerator: u64
    ): u128 {
        assert!(amount_in > 0, error::internal(EPARAMETER_INVALID));
        assert!(reserve_in > 0 && reserve_out > 0, error::internal(EPARAMETER_INVALID));

        assert!(fee_denumerator > 0 && fee_numerator > 0, error::internal(EPARAMETER_INVALID));
        assert!(fee_denumerator > fee_numerator, error::internal(EPARAMETER_INVALID));

        let amount_in_with_fee = amount_in * ((fee_denumerator - fee_numerator) as u128);
        let denominator = reserve_in * (fee_denumerator as u128) + amount_in_with_fee;
        amm_math::safe_mul_div_u128(amount_in_with_fee, reserve_out, denominator)
    }
}