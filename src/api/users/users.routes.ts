import { Router } from 'express';

import * as UsersHandlers from './users.handlers';

const router = Router();

router.get('/', UsersHandlers.findAll);

router.post('/', UsersHandlers.create);

router.post('/google', UsersHandlers.createGoogle);

export default router;
