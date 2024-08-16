import { Router } from 'express';

import * as UsersHandlers from './users.handlers';

const router = Router();

router.get('/', UsersHandlers.findAll);

router.post('/signin', UsersHandlers.emailSignIn);

router.post('/signup', UsersHandlers.emailSignUp);

router.get('/google', UsersHandlers.googleSignIn);
router.get('/google/callback', UsersHandlers.googleCallback);

export default router;
