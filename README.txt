FRAMEBANK SYNC
==============

This version:
- keeps your original starter cinema references
- lets you add new screenshots from phone or Mac
- syncs new frames across devices with Supabase
- lets you crop, rotate, flip, adjust brightness, contrast and saturation
- lets you edit metadata later
- keeps synced images private inside a user-scoped Supabase Storage bucket

SETUP SUMMARY
1. Create a free Supabase project.
2. In Supabase SQL Editor, run supabase_setup.sql.
3. In Supabase Authentication > URL Configuration, add your GitHub Pages URL as Site URL / redirect URL.
4. Copy your Supabase Project URL and anon/public key into config.js.
5. Upload/replace the contents of this folder in the root of your GitHub Framebank repository.
6. Commit changes.
7. Sign in to FrameBank with your email. Supabase sends a magic link.
8. Add images with the + button.

Never put a Supabase service_role key in config.js.
