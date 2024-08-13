import { Router } from 'express';

import * as UsersHandlers from './users.handlers';

const router = Router();

router.get('/', UsersHandlers.findAll);

export default router;
