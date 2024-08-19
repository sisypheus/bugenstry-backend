import { JwtPayload } from 'jsonwebtoken'
import { Response, Request, NextFunction } from 'express';
import { prisma } from '../../db/prisma';

type RequestWithUser = Request & { user: JwtPayload };

export async function findAll(req: Request, res: Response<any>, next: NextFunction) {
  return res.json(prisma.organization.findMany());
}

export async function create(req: Request, res: Response<any>, next: NextFunction) {
  let { name, plan_id } = req.body;

  // set the admin user to the current user
  // extract the user from the request
  // create the admin for the organization

  const organization = await prisma.organization.create({
    data: {
      name,
      plan_id
    },
  });

  const admin = await setAdmin((req as RequestWithUser).user.id, organization.id);

  return res.json({ organization, admin });
}

const setAdmin = async (user_id: string, organization_id: string) => {
  return await prisma.profile.update({
    where: {
      id: user_id
    },
    data: {
      organization_id,
      role: 'admin'
    }
  });
}