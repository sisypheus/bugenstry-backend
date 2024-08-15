import { Router } from 'express';

import * as OrganizationsHandlers from './organizations.handlers';

const router = Router();

router.get('/', OrganizationsHandlers.findAll);

export default router;