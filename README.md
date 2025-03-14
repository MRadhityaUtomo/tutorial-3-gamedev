Controls :
- WASD Movement
- Space to jump
- S to crouch

1. Added double tap on A and D to dash -> Timer to count time since last A or D input 
2. Added Double jump -> Space bar to jump, checks if in the air and has jumped once.
3. Added sprite dynamicity to change looking direction
4. Added individual State Functions to change collision and Sprite based on current action -> Utilized .Play, .Stop, .visible functions and attributes from AnimatedSprite2D and Sprite2D nodes.

I wanted to add an attack action with the sprite already in there but time constraints, I also think for future projects my code can be cleaner with defining states to change sprites.

1. Membuat minimal 1 (satu) objek baru di dalam permainan yang dilengkapi dengan animasi menggunakan spritesheet selain yang disediakan tutorial. Silakan cari spritesheet animasi di beberapa koleksi aset gratis seperti Kenney.
- Added boombox object that can be hit (rigidbody2D), emits background music using the Audiostreamplayer2d node with modified attenuation. Has its own animation using animatedsprite2d.

2. Membuat minimal 1 (satu) audio untuk efek suara (SFX) dan memasukkannya ke dalam permainan. Kamu dapat membuatnya sendiri atau mencari dari koleksi aset gratis.
- Added attack mechanic for player, can knockback boombox if hit, has its own audio when slashing and hitting.
Using area2d in player, with its own collisionshape2d as the attack"s hitbox. The signal will give force to the rigidbody2d boombox when connected.

3. Membuat minimal 1 (satu) musik latar (background music) dan memasukkannya ke dalam permainan. Kamu dapat membuatnya sendiri atau mencari dari koleksi aset gratis.
- Added bg music through boombox.

4. Implementasikan interaksi antara objek baru tersebut dengan objek yang dikendalikan pemain. Misalnya, pemain dapat menciptakan atau menghilangkan objek baru tersebut ketika menekan suatu tombol atau tabrakan dengan objek lain di dunia permainan.
- Player can attack boombox, using a signal(area2d) attached to the attack hitbox. 

5. Implementasikan audio feedback dari interaksi antara objek baru dengan objek pemain. Misalnya, muncul efek suara ketika pemain tabrakan dengan objek baru.
- Hitsound attack.
