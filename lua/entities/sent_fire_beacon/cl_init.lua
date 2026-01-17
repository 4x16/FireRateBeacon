include("shared.lua")

function ENT:Initialize()
    local b = 320
    self:SetRenderBounds(Vector(-b, -b, -b), Vector(b, b, b))
end

function ENT:Draw()
    self:DrawModel()
    local radius = 300
    render.SetColorMaterial()
    cam.Start3D2D(self:GetPos() + Vector(0, 0, 5), Angle(0, 0, 0), 1)
        for i = 0, 8 do
            surface.DrawCircle(0, 0, radius + (i * 0.5), 255, 150, 0, 150)
            surface.DrawCircle(0, 0, radius - (i * 0.5), 255, 150, 0, 150)
        end
    cam.End3D2D()
end