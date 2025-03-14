Controls :
- WASD Movement
- Space to jump
- S to crouch

1. Added double tap on A and D to dash -> Timer to count time since last A or D input 
2. Added Double jump -> Space bar to jump, checks if in the air and has jumped once.
3. Added sprite dynamicity to change looking direction
4. Added individual State Functions to change collision and Sprite based on current action -> Utilized .Play, .Stop, .visible functions and attributes from AnimatedSprite2D and Sprite2D nodes.

I wanted to add an attack action with the sprite already in there but time constraints, I also think for future projects my code can be cleaner with defining states to change sprites.
