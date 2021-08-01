pod install


Add arithmetic operators (add, subtract, multiply, divide) to make the following expressions true. You can use any parentheses you’d like.
        3 1 3 9 = 12
        ((3+1)/3)*9
        
        
        
      func test() throws {
          let codeChallange = CodeChallange()
          XCTAssertEqual(codeChallange.fibonacciRecursion(n: 10),codeChallange.fibonacciIteration(n: 10))
          XCTAssertEqual("debit card".isAnagramWith(secondString: "bad credit"), true)
          XCTAssertEqual("debitcardo".isAnagramWith(secondString: "bad credit"), false)
          XCTAssertEqual("punishments".isAnagramWith(secondString: "ninethumps"), true)
          XCTAssertEqual("punishments".isAnagramWith(secondString: "ninethums"), false)
      }
    
    
   AppDelegate
        let codeChallange = CodeChallange()
        codeChallange.checkAnagrams(first: "debit card", second: "bad credit")
        codeChallange.checkAnagrams(first: "punishments", second: "ninethumps")
        print(codeChallange.fibonacciRecursion(n: 10))
        print(codeChallange.fibonacciIteration(n: 10))
