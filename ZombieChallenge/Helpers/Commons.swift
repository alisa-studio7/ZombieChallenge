//
//  Commons.swift
//  ZombieChallenge
//
//  Created by Alisa Sapmun on 16/3/21.
//

func unwrapped<T>(_ wrapped: T?, with castValue: T) -> T {
  if let unwrapped = wrapped {
    return unwrapped
  } else {
    return castValue
  }
}
