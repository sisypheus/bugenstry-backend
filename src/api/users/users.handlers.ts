import { Response, Request, NextFunction } from 'express';
import { supabase } from '../../db/supabase';
import { z } from 'zod';
import jwt from 'jsonwebtoken';

export async function findAll(req: Request, res: Response<any>, next: NextFunction) {
  try {
    const { data, error } = await supabase.from('users').select('*');

    if (error)
      return res.status(500).json({ error: error.message });

    res.json(data);
  } catch (error) {
    next(error);
  }
}

export async function emailSignUp(req: Request, res: Response<any>, next: NextFunction) {
  try {
    const { email, password } = req.body;

    const { data, error } = await supabase.auth.signUp({
      email,
      password,
    });

    if (error)
      return res.status(400).json({ error: error.message });

    const token = signToken(data);

    res.json({ token });

  } catch (error) {
    next(error);
  }
}

export async function emailSignIn(req: Request, res: Response<any>, next: NextFunction) {
  try {
    const { email, password } = req.body;

    const { data, error } = await supabase.auth.signInWithPassword({
      email,
      password,
    });

    if (error)
      return res.status(401).json({ error: error.message });

    const token = signToken(data);

    res.json({ token });

  } catch (error) {
    next(error);
  }
}

export async function googleSignIn(req: Request, res: Response<any>, next: NextFunction) {
  try {
    const { data, error } = await supabase.auth.signInWithOAuth({
      provider: 'google',
    });

    if (error)
      return res.status(500).json({ error: error.message });

    res.redirect(data.url);
  } catch (error) {
    next(error);
  }
}

export async function googleCallback(req: Request, res: Response<any>, next: NextFunction) {
  try {
    const code = z.string().parse(req.query.code);

    if (!code)
      return res.status(400).json({ error: 'Authorization code not provided' });

    const { data, error } = await supabase.auth.exchangeCodeForSession(code);

    if (error)
      return res.status(500).json({ error: error.message });

    const token = signToken(data);

    res.json({ token });
  } catch (error) {
    next(error);
  }
}

export async function getProfile(req: Request, res: Response<any>, next: NextFunction) {
  try {
    const token = req.headers['authorization'];

    if (!token)
      return res.sendStatus(401);

    const user = verifyToken(token);

    res.json(user);
  } catch (error) {
    next(error);
  }
}

function verifyToken(token: string) {
  return jwt.verify(token, process.env.JWT_SECRET!);
}

function signToken(payload: any) {
  return jwt.sign(payload, process.env.JWT_SECRET!, { expiresIn: '72h' });
}
