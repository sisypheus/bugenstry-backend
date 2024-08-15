import { Router } from 'express';

import * as BugsHandlers from './bugs.handlers';

const router = Router();

router.get('/', BugsHandlers.findAll);

export default router;