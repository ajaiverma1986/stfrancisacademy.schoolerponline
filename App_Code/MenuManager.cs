using BusinessObjects.Entity;
using System;
using System.Collections.Generic;
using System.Xml;

public class MenuManager
{
    public int SaveRightInformation(List<Right> ListRight)
    {
        int returnValue = 0;
        try
        {
            MenuRightAccess objMenuRightAccess = new MenuRightAccess();
            returnValue = objMenuRightAccess.SaveRightInformation(BuildRightXml(ListRight));
        }
        catch (Exception ex)
        {
            throw ex;
        }

        return returnValue;
    }

    private string BuildRightXml(List<Right> ListRight)
    {
        if (ListRight == null)
            return "";
        XmlDocument objectXmlDocument = new XmlDocument();
        XmlElement RightElement = objectXmlDocument.CreateElement("Right");
        for (int i = 0; i < ListRight.Count; i++)
        {
            try
            {
                RightElement.AppendChild(BuildRightHeadXml((Right)ListRight[i], objectXmlDocument));
            }
            catch (Exception objectException)
            {
                throw objectException;
            }
        }
        objectXmlDocument.AppendChild(RightElement);
        return objectXmlDocument.OuterXml;
    }

    private static XmlElement BuildRightHeadXml(Right objRight, XmlDocument objectXmlDocument)
    {
        XmlElement RightElement = objectXmlDocument.CreateElement("Right");
        RightElement.SetAttribute("ModuleId", Convert.ToString(objRight.ModuleId));
        RightElement.SetAttribute("UserId", Convert.ToString(objRight.UserId));
        RightElement.SetAttribute("IsActive", Convert.ToString(objRight.IsActive));
        RightElement.SetAttribute("CreatedById", "");
        return RightElement;
    }
}