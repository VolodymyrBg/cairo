//! Utilities related to printing of values at runtime.
//! The recommended way of printing values is by using the `Display` and `Debug` traits
//! available in the [`fmt`] module. The items in this module are not public, and are not
//! recommended for use.

#[allow(unused_imports)]
use crate::array::ArrayTrait;
#[allow(unused_imports)]
use crate::option::Option;
use crate::traits::Into;

pub(crate) extern fn print(message: Array<felt252>) nopanic;

fn print_felt252(message: felt252) {
    print(array![message]);
}

/// A trait for printing values for debugging purposes.
/// Accessible with prelude editions prior to `2024_07`.
///
/// # Examples
///
/// ```
/// use core::debug::PrintTrait;
///
/// 1.print();
/// (1 == 2).print();
///
/// let mut arr = array![];
/// arr.append('1234567890123456789012345678901');
/// arr.append('Sca');
/// arr.append('SomeVeryLongMessage');
/// arr.print();
/// ```
pub(crate) trait PrintTrait<T> {
    fn print(self: T);
}

pub(crate) impl Felt252PrintImpl of PrintTrait<felt252> {
    fn print(self: felt252) {
        print_felt252(self);
    }
}

pub(crate) impl BoolPrintImpl of PrintTrait<bool> {
    fn print(self: bool) {
        if self {
            'true'.print();
        } else {
            'false'.print();
        }
    }
}

pub(crate) impl ContractAddressPrintImpl of PrintTrait<starknet::ContractAddress> {
    fn print(self: starknet::ContractAddress) {
        Into::<_, felt252>::into(self).print();
    }
}

pub(crate) impl U8PrintImpl of PrintTrait<u8> {
    fn print(self: u8) {
        Into::<_, felt252>::into(self).print();
    }
}

pub(crate) impl U16PrintImpl of PrintTrait<u16> {
    fn print(self: u16) {
        Into::<_, felt252>::into(self).print();
    }
}

pub(crate) impl U32PrintImpl of PrintTrait<u32> {
    fn print(self: u32) {
        Into::<_, felt252>::into(self).print();
    }
}

pub(crate) impl U64PrintImpl of PrintTrait<u64> {
    fn print(self: u64) {
        Into::<_, felt252>::into(self).print();
    }
}

pub(crate) impl U128PrintImpl of PrintTrait<u128> {
    fn print(self: u128) {
        Into::<_, felt252>::into(self).print();
    }
}

pub(crate) impl U256PrintImpl of PrintTrait<u256> {
    fn print(self: u256) {
        Into::<u128, felt252>::into(self.low).print();
        Into::<u128, felt252>::into(self.high).print();
    }
}

pub(crate) impl I8PrintImpl of PrintTrait<i8> {
    fn print(self: i8) {
        Into::<_, felt252>::into(self).print();
    }
}

pub(crate) impl I16PrintImpl of PrintTrait<i16> {
    fn print(self: i16) {
        Into::<_, felt252>::into(self).print();
    }
}

pub(crate) impl I32PrintImpl of PrintTrait<i32> {
    fn print(self: i32) {
        Into::<_, felt252>::into(self).print();
    }
}

pub(crate) impl I64PrintImpl of PrintTrait<i64> {
    fn print(self: i64) {
        Into::<_, felt252>::into(self).print();
    }
}

pub(crate) impl I128PrintImpl of PrintTrait<i128> {
    fn print(self: i128) {
        Into::<_, felt252>::into(self).print();
    }
}

pub(crate) impl ArrayGenericPrintImpl of PrintTrait<Array<felt252>> {
    fn print(mut self: Array<felt252>) {
        print(self);
    }
}

/// Prints a `ByteArray` as a string.
///
/// # Examples
///
/// ```
/// let ba: ByteArray = "123";
/// print_byte_array_as_string(@ba);
/// ```
pub fn print_byte_array_as_string(self: @ByteArray) {
    let mut serialized = array![crate::byte_array::BYTE_ARRAY_MAGIC];
    self.serialize(ref serialized);
    print(serialized)
}

