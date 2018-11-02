<p align="center">
<img src="docs/deu-total-deepsaffron-transparent.png" height="120px" alt="Deu Logo" title="Deu Logo">
</p>
<!-- *** -->
**Deu** is a powerful, general purpose, interpreted programming language made in [D](http://dlang.org/).  
It is easy to learn, providing a bunch of features, such as [dynamic and static typing](https://en.wikipedia.org/wiki/Type_system#Static_and_dynamic_type_checking_in_practice) or [object-oriented programming](https://en.wikipedia.org/wiki/Object-oriented_programming).
Deu's syntax is inspired by [JavaScript](https://en.wikipedia.org/wiki/JavaScript), [Python](https://en.wikipedia.org/wiki/Python_(programming_language)), [D](https://en.wikipedia.org/wiki/D_(programming_language)) and real-world experiences.

## __Getting Started__
The interpreter is not complete yet.

## __Examples__
```python
print "Hello World!"; # output = string: "Hello World!"
```

```javascript
import std.io;

function main() {
   let name = io.input("> ");
   io.println("hi " ++ name ++ "!");
}
```

```d
class Math {
   function sum(ref real: n1, ref real: n2) {
      return <n1 + n2>;
   }

   function rest(ref real: n1, ref real: n2) {
      return sum(n1, -n2);
   }
}
```

```javascript
import std.io;
import std.algorithm;

function main() {

   let elementsCount = 5;
   let elements = [];

   for(i; 0, elementsCount) {
      elements.push(
         io.input("element " ++ i ++ ": ")
      );
   }

   elements = elements.sort();

   io.println(elements)
}

```

See [samples](https://github.com/deu-lang/deu/tree/master/samples) to see a few more examples.

## __License__
Deu is available under the BSL-1.0 license.
