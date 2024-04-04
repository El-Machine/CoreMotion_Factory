/// Copyright © 2020-2024 El Machine 🤖
///
/// Permission is hereby granted, free of charge, to any person obtaining a copy
/// of this software and associated documentation files (the "Software"), to deal
/// in the Software without restriction, including without limitation the rights
/// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
/// copies of the Software, and to permit persons to whom the Software is
/// furnished to do so, subject to the following conditions:
///
/// The above copyright notice and this permission notice shall be included in
/// all copies or substantial portions of the Software.
///
/// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
/// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
/// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
/// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
/// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
/// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
/// THE SOFTWARE.
///
/// Created by Alex Kozin
///

public
protocol Wanded {

    var wand:       Wand    {get}
    var isWanded:   Wand?   {get}

}

public 
extension Wanded {

    var wand:       Wand    {
        isWanded ?? Wand(for: self)
    }

    var isWanded:   Wand?   {
        Wand[self]
    }

}

extension Optional: Wanded {

    public
    var pipe: Wand {
        isPiped ?? Wand.attach(to: self)
    }

    public
    var isPiped: Wand? {
        Wand[self]
    }

}

public 
extension Wanded where Self: AnyObject {

    var address: Int {
        Int(bitPattern: Unmanaged.passUnretained(self).toOpaque())
    }

}

public 
extension Wanded {

    var address: Int {
        var address: Int!
        var mutable = self
        withUnsafePointer(to: &mutable) { pointer in
            address = Int(bitPattern: pointer)
        }

        return address!
    }

}

//NO FUCKING WAY, it breaks Pipe.attach(to: array)
//extension Array: Pipable {
//
//}


//struct MemoryAddress<T> {
//
////    let intValue: Int
////
////    var description: String {
////        let length = 2 + 2 * MemoryLayout<UnsafeRawPointer>.size
////        return String(format: "%0\(length)p", intValue)
////    }
////
////    // for structures
////    init(of structPointer: UnsafePointer<T>) {
////        intValue = Int(bitPattern: structPointer)
////    }
//
//    static func address(of model: T) -> Int {
//        var address: Int!
//        var mutable = model
//        withUnsafePointer(to: &mutable) { pointer in
//            address = Int(bitPattern: pointer)
//        }
//
//        return address
//    }
//}
//
//extension MemoryAddress where T: AnyObject {
//
////    // for classes
////    init(of classInstance: T) {
////        intValue = unsafeBitCast(classInstance, to: Int.self)
////        // or      Int(bitPattern: Unmanaged<T>.passUnretained(classInstance).toOpaque())
////    }
//
//
//    static func address(of model: T) -> Int {
//        unsafeBitCast(model, to: Int.self)
//    }
//
//
//}
