#  Notes
I have had to do a lot of googling.
I've compiled what I learned about Swift and SwiftUI below for future reference

## Computed Properties
Variables that are declared like this:
`var myVar: Double {...}` are called *computed properties*.
They are dressed up setters and getters; almost exactly like C# properties.
```swift
var center: Point {
        get {
            let centerX = origin.x + (size.width / 2)
            let centerY = origin.y + (size.height / 2)
            return Point(x: centerX, y: centerY)
        }
        set(newCenter) {
            origin.x = newCenter.x - (size.width / 2)
            origin.y = newCenter.y - (size.height / 2)
        }
    }
```
In SwiftUI you'll see them a lot like this:
```swift
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text("Hello, world!")
        }
        .padding()
    }
```
Swift computed properties MUST have at least a getter but can optionally also have setters.
If the setter is omitted, you can also leave out the `get` keyword and just write the code that returns the object.
```swift
// I.e.,
var myCar: Car {
    get {
        Car()
    }
}
}

// is equivalent to
var myCar: Car{ Car() }
```
## Closures and Trailing Closure Syntax
This one took forever to figure out.
But I got the gist of it from the chapter on closures in the Swift Programming Language book (p. 68-70).
### Closures
In this code:
```swift
@main
struct CAFEApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
```
You'll notice we create a *property* called body of some type that implements the Scene protocol.
The getter for this property is this weird line that says WindowGroup{...} but that doesn't make any sense right? What does this line do? Is it a function declaration idk...
Turns out it a whole slew of simplifications. I've rewritten this code below without any sugar so you can see what's going on.
```swift
// ...
var body: some Scene {
    get {
        WindowGroup(closure: { () -> Void in
            ContentView()
        })
    }
}
```
So really what's happening is `WindowGroup` is a constructor that takes a function (closure) as its final (and only) parameter.
This function takes no arguments and returns nothing (since all that matters are the fields in its scope) so we can omit the parentheses for its parameters and its return type and arrow.
What we're left with is the lanky looking
```swift
// ...
WindowGroup({ ContentView() })
```
### Trailing Closure Syntax
Now heres where the brainfuckery gets even realer
In swift if the final parameter for a constructor is a closure we can just *move it outside of the function*
```swift
WindowGroup() {
    // this block of code is actually a parameter of the WindowGroup constructor
    ContentView()
}
```

And if you want to let the brainfuckery get even realer, when the constructor only has 1 parameter AND its a closure (like in this case) you can just **get rid of the function parentheses**... giving us our final answer `WindowGroup {ContentView()}` 😀
And that's just the template!! We haven't even started writing code!