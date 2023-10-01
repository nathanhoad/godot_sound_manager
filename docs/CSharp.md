# Usage with C#

To use the Sound Manager with C# you just need to add a `using NathanHoad;` statement to the file and then call PascalCase versions of the methods outlined in [Sound effects](./Sounds.md) and [Music](./Music.md).

For example, to play a sound in GDScript you would call `SoundManager.play_sound(some_sound)` but in C# it would look more like:

```csharp
using NathanHoad;
```

And then...

```csharp
SoundManager.PlaySound(someSound);
```
