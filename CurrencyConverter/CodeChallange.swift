//
//  CodeChallange.swift
//  CurrencyConverter
//
//  Created by Mohamed Elzohirey on 01/08/2021.
//

import Foundation

class CodeChallange {
    // Using Iteration
    func fibonacciIteration (n: Int) -> Int {
        var fibonacciArray = [1, 1]
        (2...n).forEach { i in
            fibonacciArray.append(fibonacciArray[i - 1] + fibonacciArray[i - 2])
        }
        return fibonacciArray.last ?? 0
    }
    
    // Using Recursion
    func fibonacciRecursion(n: Int) -> Int {
        guard n != 0, n != 1, n != 2 else { return n }
        return fibonacciRecursion(n: n - 2) + fibonacciRecursion(n: n - 1)
    }
    func checkAnagrams(first: String, second: String){
        print("debit card".isAnagramWith(secondString: "bad credit"))
        print("punishments".isAnagramWith(secondString: "ninethumps"))
    }
}
extension String{
    func isAnagramWith(secondString: String) -> Bool {
        //remove duplicates
        //remove white spaces
        var set1 = Set<Character>()
        var set2 = Set<Character>()
        return self.filter{
            if $0 != " "{
                return set1.insert($0).inserted
            }
            return false
        }.lowercased().sorted() == secondString.filter{
            if $0 != " "{
                return set2.insert($0).inserted
            }
            return false
        }.lowercased().sorted()
    }
}
